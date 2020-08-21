package com.lanqiao.service.impl;

import com.github.pagehelper.PageHelper;
import com.lanqiao.entity.Cinema;
import com.lanqiao.entity.Film;
import com.lanqiao.mapper.CinemaMapper;
import com.lanqiao.service.ICinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("cinemaService")
public class CinemaServiceImpl implements ICinemaService {

    @Autowired
    CinemaMapper cinemaMapper;

    /**
     * find all cinema
     *
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public List<Cinema> findAll(Cinema condition, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return this.cinemaMapper.findAll(condition, pageNum, pageSize);
    }

    /**
     * find cinema by id
     *
     * @param cinemaId
     * @return
     */
    @Override
    public Cinema findCinemaById(Integer cinemaId) {
        return this.cinemaMapper.findCinemaById(cinemaId);
    }

    @Override
    public int updateCinema(Cinema cinema) {
        return this.cinemaMapper.updateCinema(cinema);
    }

    @Override
    public int insertCinema(Cinema cinema) {
        return this.cinemaMapper.insertCinema(cinema);
    }

    /**
     * 查询不在次电影院的电影
     *
     * @param cinemaId
     * @return
     */
    @Override
    public List<Film> findFilmByCinemaId(Integer cinemaId) {
        return this.cinemaMapper.findFilmByCinemaId(cinemaId);
    }

    /**
     * 批量上架电影
     * @param cinemaId
     * @param filmIdList
     * @return
     */
    @Override
    public int insertFilmIntoCinema(Integer cinemaId, Integer filmIdList) {
        return this.cinemaMapper.insertFilmIntoCinema(cinemaId, filmIdList);
    }

    /**
     * 查询在此电影院的电影
     * @param cinemaId
     * @return
     */
    @Override
    public List<Film> findFilmOnShelves(Integer cinemaId) {
        return this.cinemaMapper.findFilmOnShelves(cinemaId);
    }

    /**
     * 下架
     * @param cinemaId
     * @param filmId
     * @return
     */
    @Override
    public int delFilmFromCinema(Integer cinemaId, Integer filmId) {
        return this.cinemaMapper.delFilmFromCinema(cinemaId, filmId);
    }
}
