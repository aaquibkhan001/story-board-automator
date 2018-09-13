package com.coffeebeans.auto.util;


public class AutomatorException extends Exception {

    private static final long serialVersionUID = 74333323422776147L;

    public AutomatorException(String iKey, String iMsg) {
        this.exceptionKey = iKey;
        this.message = iMsg;
    }
 
    private String exceptionKey;
    private String message;

    public String toString() {
        return ("Exception occurred. KEY = " + exceptionKey + " MSG = " + message);
    }
}
