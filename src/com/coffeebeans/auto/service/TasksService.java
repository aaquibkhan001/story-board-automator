package com.coffeebeans.auto.service;

import java.util.List;

import com.coffeebeans.auto.entity.TaskHistory;
import com.coffeebeans.auto.entity.Tasks;

public interface TasksService {

    Tasks getUserById(int iTaskId);
    
    int createTask(Tasks iTask);

    int editTask(Tasks iTask);

    int deleteTask(int iTaskId);

    List<Tasks> getAllTasks();
    
    List<TaskHistory> getTaskHistory(int iTaskId);
}
