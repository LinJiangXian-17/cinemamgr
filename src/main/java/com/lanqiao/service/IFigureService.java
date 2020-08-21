package com.lanqiao.service;

import com.lanqiao.entity.Figure;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IFigureService {
    public List<Figure> findAllFigure(Figure condition,int pageNum,int pageSize);

    public int insertFigure(Figure figure);

    public int deleteFigureById(Integer figureId);
}
