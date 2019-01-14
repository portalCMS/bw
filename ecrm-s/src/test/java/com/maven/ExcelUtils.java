package com.maven;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.maven.util.FileUtils;

public class ExcelUtils {

	public static void main(String[] args) {

	}

	public static void processExcel() {
		String path = "C:\\Users\\admin\\Desktop\\QB\\和记MG接口\\2017新接口\\MG_Game_List_July_2017_Dashur.xlsx";
		// 初始化输入流
		InputStream is = null;
		try {
			// 根据新建的文件实例化输入流
			is = new FileInputStream(path);
			File file = new File(path);
			// 根据版本选择创建Workbook的方式
			Workbook wb = null;
			// 根据文件名判断文件是2003版本还是2007版本
			if (FileUtils.isExcel2007(file.getName())) {
				wb = new XSSFWorkbook(is);
			} else {
				wb = new HSSFWorkbook(is);
			}
			// 得到第一个shell
			Sheet sheet = wb.getSheetAt(0);
			// 得到Excel的行数
			int totalRows = sheet.getPhysicalNumberOfRows();
			// 总列数
			int totalCells = 0;
			// 得到Excel的列数(前提是有行数)，从第二行算起
			if (totalRows >= 1 && sheet.getRow(1) != null) {
				totalCells = sheet.getRow(1).getPhysicalNumberOfCells();
			}
			// 循环Excel行数,从第二行开始。标题不入库
			int q = 999;
			for (int r = 1; r < 451; r++) {
				q++;
				Row row = sheet.getRow(r);
				if (row == null) {
					continue;
				}
				// 循环Excel的列
				String a = "";
				String b = "", d = "", e = "";
				double x = 0, y = 0;
				for (int c = 0; c < totalCells; c++) {
					Cell cell = row.getCell(c);
					if (null != cell) {
						if (c == 4 || c == 5) {
							if (cell.getNumericCellValue() == 0) {
								continue;
							}
						}
						if (c == 0) {
							a = cell.getStringCellValue();
						} else if (c == 1) {
							b = cell.getStringCellValue();
						} else if (c == 4) {
							x = cell.getNumericCellValue();
						} else if (c == 5) {
							y = cell.getNumericCellValue();
						} else if (c == 18) {
							d = cell.getStringCellValue();
						} else if (c == 26) {
							e = cell.getStringCellValue();
							if (e.indexOf("/") != -1) {
								e = e.split("/")[0].trim() + ".png";
							} else {
								e += ".png";
							}
							if (".png".equals(e))
								continue;
						}
					}
				}
				String s = "INSERT INTO `mg_electronic_new` VALUES (" + q + ", '" + d + "', '" + a + "', '" + a + "', '"
						+ e + "', '" + a + "', '" + b + "', null, '" + (int) x + "', '" + (int) y + "', '1', '400', "
						+ q + ", '1');";
				System.out.println(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					is = null;
					e.printStackTrace();
				}
			}
		}
	}
}
