package service;

import java.io.File;
import java.io.UnsupportedEncodingException;

public class UtilMgr {
	public static String con(String s) {
		String str= null;
		try {
			str = new String(s.getBytes("8859_1"), "UTF-8");		//한글로 돌리기
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}
	
	public static void delete(String s) {
		File file = new File(s);
		if(file.isFile()) {		//파일이 있으면
			file.delete();		//파일 삭제
		}
	}
}
