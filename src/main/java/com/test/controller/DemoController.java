package com.test.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class DemoController {

    @GetMapping("/health")
    public ResponseEntity healthCheck() {
        log.info("Successfully Called Health Check Endpoint..");
        return ResponseEntity.ok("Health Check Completed...");
    }
}
