package com.maven.util;

/**
 * Excel工具类
 * @author andy
 * @date 2017年7月20日 下午1:39:43
 * 
 */
public class FileUtils {
	/**
	 * 是否是CSV格式
	 * 
	 * @param filePath
	 * @return
	 */
	public static boolean isCSV(String filePath) {
		return filePath.matches("^.+\\.(?i)(csv)$");
	}

	/**
	 * 是否是2003的excel，返回true是2003
	 * 
	 * @param filePath
	 * @return
	 */
	public static boolean isExcel2003(String filePath) {
		return filePath.matches("^.+\\.(?i)(xls)$");
	}

	/**
	 * 是否是2007的excel，返回true是2007
	 * 
	 * @param filePath
	 * @return
	 */
	public static boolean isExcel2007(String filePath) {
		return filePath.matches("^.+\\.(?i)(xlsx)$");
	}

	/**
	 * 验证EXCEL文件
	 * 
	 * @param filePath
	 * @return
	 */
	public static boolean validateExcel(String filePath) {
		if (filePath == null || !(isExcel2003(filePath) || isExcel2007(filePath))) {
			return false;
		}
		return true;
	}
}
