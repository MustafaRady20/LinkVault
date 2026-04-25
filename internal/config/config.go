package config

import (
	"fmt"
	"log"

	"github.com/joho/godotenv"
	"github.com/spf13/viper"
)

type Config struct {
	App App `mapstructure:"app"`
	DB  DB  `mapstructure:"db"`
}

type App struct {
	Port string `mapstructure:"port"`
	Env  string `mapstructure:"env"`
}

type DB struct {
	Host        string `mapstructure:"host"`
	Port        int    `mapstructure:"port"`
	User        string `mapstructure:"user"`
	Password    string `mapstructure:"password"`
	Name        string `mapstructure:"name"`
	SSLMode     string `mapstructure:"sslmode"`
	MaxOpenConn int    `mapstructure:"maxopenconn"`
	MaxIdleConn int    `mapstructure:"maxidleconn"`
	MaxIdleTime string `mapstructure:"maxidletime"`
}

func Load() (*Config, error) {
	_ = godotenv.Load()
	viper.SetDefault("app.port", ":8080")
	viper.SetDefault("app.env", "development")
	viper.SetDefault("db.port", 5432)
	viper.SetDefault("db.sslmode", "disable")
	viper.SetDefault("db.maxopenconn", 25)
	viper.SetDefault("db.maxidleconn", 25)
	viper.SetDefault("db.maxidletime", "15m")

	viper.AutomaticEnv()
	// TODO:
	// panic if not db host or password

	dbHost := viper.GetString("POSTGRES_HOST")
	dbPort := viper.GetInt("POSTGRES_PORT")

	if dbHost == "" || dbPort == 0 {
		log.Fatal("DB_HOST and DB_PORT environment variables must be set")
	}
	bindings := map[string]string{
		"app.port":       "APP_PORT",
		"app.env":        "APP_ENV",
		"db.host":        "POSTGRES_HOST",
		"db.port":        "POSTGRES_PORT",
		"db.user":        "POSTGRES_USER",
		"db.password":    "POSTGRES_PASSWORD",
		"db.name":        "POSTGRES_DB",
		"db.sslmode":     "POSTGRES_SSLMODE",
		"db.maxopenconn": "DB_MAX_OPEN_CONN",
		"db.maxidleconn": "DB_MAX_IDLE_CONN",
		"db.maxidletime": "DB_MAX_IDLE_TIME",
	}

	for key, env := range bindings {
		if err := viper.BindEnv(key, env); err != nil {
			return nil, fmt.Errorf("failed to bind env var %s: %w", env, err)
		}
	}

	var cfg Config
	if err := viper.Unmarshal(&cfg); err != nil {
		return nil, fmt.Errorf("failed to unmarshal config: %w", err)
	}

	return &cfg, nil
}

func (c *Config) DSN() string {

	return fmt.Sprintf(
		"postgres://%s:%s@%s:%d/%s?sslmode=%s",
		c.DB.User, c.DB.Password,
		c.DB.Host, c.DB.Port,
		c.DB.Name, c.DB.SSLMode,
	)
}
