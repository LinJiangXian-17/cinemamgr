package com.lanqiao.service.impl;

import com.github.pagehelper.PageHelper;
import com.lanqiao.entity.Film;
import com.lanqiao.mapper.FilmMapper;
import com.lanqiao.service.IFilmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("FilmService")
public class FilmServiceImpl implements IFilmService {

    @Autowired
    FilmMapper filmMapper;

    @Override
    public List<Film> selectAll(Film condition, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return this.filmMapper.selectAll(condition, pageNum, pageSize);
    }

    /**
     * 即将上映
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<Film> selectAllUpComing(Film condition, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return this.filmMapper.selectAllUpComing(condition, pageNum, pageSize);
    }

    /**
     * 热播电影
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<Film> selectAllHit(Film condition, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return this.filmMapper.selectAllHit(condition,pageNum,pageSize);
    }

    /**
     * select film by id
     * @param filmId
     * @return
     */
    @Override
    public Film selectById(Integer filmId) {
        return this.filmMapper.selectById(filmId);
    }

    /**
     * update
     * @param film
     * @return
     */
    @Override
    public int updateFilm(Film film) {
        return this.filmMapper.updateFilm(film);
    }

    /**
     * add film
     * @param film
     * @return
     */
    @Override
    public int insertFilm(Film film) {
        return this.filmMapper.insertFilm(film);
    }

    /**
     * 将即将上映移到正在热映或者热播电影
     *
     * @param filmId
     * @param score
     * @param wish
     * @return
     */
    @Override
    public int updateToHit(Integer filmId, Double score) {
        return this.filmMapper.updateToHit(filmId, score);
    }
}
