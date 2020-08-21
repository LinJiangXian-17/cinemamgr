package com.lanqiao.service;

import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IFilmService {

    /**
     * 正在热映
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAll( Film condition, int pageNum, int pageSize);

    /**
     * 即将上映
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAllUpComing( Film condition, int pageNum, int pageSize);


    /**
     * 热播电影
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAllHit( Film condition, int pageNum, int pageSize);

    /**
     * select film by id
     * @param filmId
     * @return
     */
    public Film selectById(Integer filmId);

    /**
     * update
     * @param film
     * @return
     */
    public int updateFilm(Film film);


    /**
     * add film
     * @param film
     * @return
     */
    public int insertFilm(Film film);

    /**
     * 将即将上映移到正在热映或者热播电影
     * @param filmId
     * @param score
     * @return
     */
    public int updateToHit(Integer filmId,Double score);
}
