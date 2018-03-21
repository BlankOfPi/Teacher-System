package cn.tdog.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatUtil {
	public static void main(String[] args) {
		
		System.out.println(timeStamp2Date("1417792627"));
	}

	public static String timeStamp2Date(String seconds) {  
        if(seconds == null || seconds.isEmpty() || seconds.equals("null")){  
            return "";  
        }  
        String format = "yyyy-MM-dd";  
        SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(Long.valueOf(seconds+"000")));  
    }  

}
