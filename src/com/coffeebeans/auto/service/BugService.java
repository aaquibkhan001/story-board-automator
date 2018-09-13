package com.coffeebeans.auto.service;

import java.util.List;

import com.coffeebeans.auto.entity.Bugs;

public interface BugService {

    int openBug(Bugs iBug);

    int updateBug(Bugs iBug);

    void deleteBug(int iBugId);

    List<Bugs> getAllBugs();
    
}
