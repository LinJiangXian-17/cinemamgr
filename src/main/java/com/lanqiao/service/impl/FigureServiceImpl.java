package com.lanqiao.service.impl;

import com.github.pagehelper.PageHelper;
import com.lanqiao.entity.Figure;
import com.lanqiao.mapper.FigureMapper;
import com.lanqiao.service.IFigureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FigureServiceImpl implements IFigureService {

    @Autowired
    FigureMapper figureMapper;

    @Override
    public List<Figure> findAllFigure(Figure condition, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return this.figureMapper.findAllFigure(condition, pageNum, pageSize);
    }

    @Override
    public int insertFigure(Figure figure) {
        return this.figureMapper.insertFigure(figure);
    }

    @Override
    public int deleteFigureById(Integer figureId) {
        return this.figureMapper.deleteFigureById(figureId);
    }
}
