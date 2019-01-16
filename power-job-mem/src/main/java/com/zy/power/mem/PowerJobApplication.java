package com.zy.power.mem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan("com.zy.power.mem.mapper")
public class PowerJobApplication {

	public static void main(String[] args) {
		SpringApplication.run(PowerJobApplication.class, args);
	}
}
