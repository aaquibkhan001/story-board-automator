package com.coffeebeans.auto.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver{
    

    @Override
    protected void logException(Exception ex, HttpServletRequest request) {
        //this.logger.error(buildLogMessage(ex, request), ex);
    }
    
}