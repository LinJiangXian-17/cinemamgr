package com.lanqiao.service;

import com.lanqiao.entity.Cinema;
import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ICinemaService {

    /**
     * find all cinema
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Cinema> findAll(Cinema condition,int pageNum, int pageSize);

    /**
     * find cinema by id
     * @param cinemaId
     * @return
     */
    public Cinema findCinemaById(Integer cinemaId);

    public int updateCinema(Cinema cinema);

    public int insertCinema(Cinema cinema);

    /**
     * 查询不在此电影院的电影
     * @param cinemaId
     * @return
     */
    public List<Film> findFilmByCinemaId(Integer cinemaId);

    /**
     * 上架电影
     * @param cinemaId
     * @param filmIdList
     * @return
     */
    public int insertFilmIntoCinema(Integer cinemaId,Integer filmIdList);

    /**
     * 查询在此电影院的电影
     * @param cinemaId
     * @return
     */
    public List<Film> findFilmOnShelves(Integer cinemaId);

    /**
     * 下架
     * @param cinemaId
     * @param filmId
     * @return
     */
    public int delFilmFromCinema(Integer cinemaId,Integer filmId);
}
