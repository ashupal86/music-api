package com.enigmacamp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
	
	@Bean
	public Docket api() {
		return new Docket(DocumentationType.SWAGGER_2)
				.select()
				.apis(RequestHandlerSelectors.basePackage("com.enigmacamp.controllers"))
				.paths(PathSelectors.any())
				.build()
				.apiInfo(getApiInfo())
				.useDefaultResponseMessages(false)
				.enableUrlTemplating(false)
				.forCodeGeneration(true)
				.ignoredParameterTypes(java.sql.Date.class)
				.directModelSubstitute(java.time.LocalDate.class, java.sql.Date.class)
				.directModelSubstitute(java.time.ZonedDateTime.class, java.util.Date.class)
				.directModelSubstitute(java.time.LocalDateTime.class, java.util.Date.class);
	}
	
	private ApiInfo getApiInfo() {
		return new ApiInfoBuilder()
				.title("Music-API Documentation")
				.description("Documentation for Music-App REST-API")
				.version("1.0.0")
				.build();
	}
}
