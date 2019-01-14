package com.hy.pull.common.util.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Page implements Serializable {
	private static final long serialVersionUID = 6519639812372284119L;
	public static final Integer PAGE_BEGIN_INDEX = 1;
	public static final Integer PAGE_DEFAULT_SIZE = 20;
	private Integer pageNumber;
	private Integer totalPages;
	private Integer pagesize;
	private List pageContents;;
	private Integer totalRecords;

	public Page() {
		pageNumber = 0;
		totalPages = 0;
		pagesize = 0;
		pageContents = new ArrayList();
		totalRecords = 0;
	}

	public Page(List pageContents) {
		pageNumber = 0;
		totalPages = 0;
		pagesize = 0;
		this.pageContents = pageContents;
		totalRecords = 0;
		this.pageContents = pageContents;
	}

	public List getPageContents() {
		return pageContents;
	}

	public Integer getPageNumber() {
		return pageNumber;
	}

	public Integer getTotalPages() {
		return totalPages;
	}

	public Integer getTotalRecords() {
		return totalRecords;
	}

	public void setPageContents(List pageContents) {
		this.pageContents = pageContents;
	}

	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}

	public void setTotalPages(Integer totalPages) {
		if (pageNumber != null)
			pageNumber = totalPages.intValue() >= pageNumber.intValue() ? pageNumber : PAGE_BEGIN_INDEX;
		this.totalPages = totalPages;
	}

	public void setTotalRecords(Integer totalRecords) {
		this.totalRecords = totalRecords;
	}

	public static Page createPage(int index, int pageSize, List records, int totalSize) {
		Page page = new Page();
		page.setPageNumber(index);
		page.setPagesize(pageSize);
		page.setPageContents(records);
		page.setTotalRecords(totalSize);
		int totalPages = (totalSize / pageSize) + ((totalSize % pageSize) > 0 ? 1 : 0);
		page.setTotalPages(totalPages);
		return page;
	}

	@Override
	public String toString() {
		return (new StringBuilder("Page[pageNumber:")).append(pageNumber).append(";size:").append(pagesize)
				.append(";totalPages:").append(totalPages).append(";pageContent:").append(pageContents.toString())
				.append("]").toString();
	}

	public Integer getPagesize() {
		return pagesize;
	}

	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}
}