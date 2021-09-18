package main

import (
	"fmt"
	"github.com/go-pg/migrations"
)

func init() {
	err := migrations.Register(func(db migrations.DB) error {
		fmt.Println("creating table players")
		_, err := db.Exec(`
CREATE TABLE IF NOT EXISTS players (
  id VARCHAR PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  last_login TIMESTAMP WITH TIME ZONE DEFAULT now(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);
`)

		return err
	}, func(db migrations.DB) error {
		fmt.Println("dropping table players")
		_, err := db.Exec(`DROP TABLE players`)
		return err
	})
	if err != nil {
		panic(err)
	}
}