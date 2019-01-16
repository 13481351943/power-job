package com.zy.power.mem.common.util;
import java.util.UUID;

public class UUIDUtil {
	
    public static String generateID() {  
       UUID.randomUUID();
       return UUID.randomUUID().toString().replaceAll("-", ""); 
    }  
}