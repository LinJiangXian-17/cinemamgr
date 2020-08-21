package com.lanqiao.mapper;

import com.lanqiao.entity.Cinema;
import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CinemaMapper {

    /**
     * 查询所有影院
     * @return
     */
    public List<Cinema> findAll(@Param("c") Cinema condition,
                                @Param("pageNum") int pageNum,
                                @Param("pageSize") int pageSize);

    public Cinema findCinemaById(Integer cinemaId);

    public int updateCinema(Cinema cinema);

    public int insertCinema(Cinema cinema);

    /**
     * 查询还未上架的电影
     * @param cinemaId
     * @return
     */
    public List<Film> findFilmByCinemaId(Integer cinemaId);

    public int insertFilmIntoCinema(@Param("cinemaId") Integer cinemaId,@Param("filmId") Integer filmId);

    /**
     * 查询已经上架的电影
     * @param cinemaId
     * @return
     */
    public List<Film> findFilmOnShelves(Integer cinemaId);

    public int delFilmFromCinema(@Param("cinemaId") Integer cinemaId,@Param("filmId") Integer filmId);
}
