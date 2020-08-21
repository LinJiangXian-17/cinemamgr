package com.lanqiao.mapper;

import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FilmMapper {

    /**
     * 查询正在热映
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAll(@Param("f") Film condition,
                                @Param("pageNum") int pageNum,
                                @Param("pageSize") int pageSize);

    /**
     * 查询即将上映
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAllUpComing(@Param("f") Film condition,
                                @Param("pageNum") int pageNum,
                                @Param("pageSize") int pageSize);

    /**
     * 查询正在热播
     * @param condition
     * @param pageNum
     * @param pageSize
     * @return
     */
    public List<Film> selectAllHit(@Param("f") Film condition,
                                @Param("pageNum") int pageNum,
                                @Param("pageSize") int pageSize);

    public Film selectById(Integer FilmId);

    /**
     * 更新电影信息
     * @param film
     * @return
     */
    public int updateFilm(Film film);

    public int insertFilm(Film film);


    /**
     * 将即将上映移到正在热映或者热播电影
     * @param filmId
     * @param score
     * @return
     */
    public int updateToHit(@Param("filmId") Integer filmId,@Param("score")Double score);
}
