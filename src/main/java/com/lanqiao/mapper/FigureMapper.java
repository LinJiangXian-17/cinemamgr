package com.lanqiao.mapper;

import com.lanqiao.entity.Figure;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FigureMapper {

    public List<Figure> findAllFigure(@Param("c")Figure condition,
                                      @Param("pageNum") int pageNum,
                                      @Param("pageSize") int pageSize);

    public int insertFigure(Figure figure);

    public int deleteFigureById(Integer figureId);
}
