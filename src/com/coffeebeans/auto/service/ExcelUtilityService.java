package com.coffeebeans.auto.service;

import java.util.List;

import com.coffeebeans.auto.util.AutomatorException;

public interface ExcelUtilityService {

    void exportDetailedReportToExcel(String iFile, List<Integer> iSelectedTasks) throws AutomatorException ;    

}
