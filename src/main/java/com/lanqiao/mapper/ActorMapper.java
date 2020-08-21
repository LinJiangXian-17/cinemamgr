package com.lanqiao.mapper;

import com.lanqiao.entity.Actor;
import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActorMapper {

    public List<Actor> findAll(@Param("a") Actor actor,
                               @Param("pageNum") int pageNum,
                               @Param("pageSize") int pageSize);

    public List<Film> findWorkToAdd(Integer actorId);

    /**
     * 为演员添加作品（或者说为电影添加演员信息）
     * @param filmId
     * @param actorId
     * @return
     */
    public int insertWorkForActor(@Param("filmId") Integer filmId,@Param("actorId")Integer actorId);


    public int insertActor(Actor actor);

    public List<Actor> selectActorsForFilm(Integer filmId);
}
