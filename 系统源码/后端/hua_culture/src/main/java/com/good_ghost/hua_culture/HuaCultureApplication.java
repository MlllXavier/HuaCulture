package com.good_ghost.hua_culture;

import com.good_ghost.hua_culture.config.Global;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;

import javax.servlet.MultipartConfigElement;

@SpringBootApplication
@MapperScan("com.good_ghost.hua_culture.mapper")
public class HuaCultureApplication {

    public static void main(String[] args) {

        SpringApplication.run(HuaCultureApplication.class, args);

    }

}
