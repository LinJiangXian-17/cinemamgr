package com.lanqiao.service;

import com.lanqiao.entity.Actor;
import com.lanqiao.entity.Film;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IActorService {

    public List<Actor> findAll(Actor actor,int pageNum, int pageSize);

    /**
     * 查询该演员为参演的作品
     * @param actorId
     * @return
     */
    public List<Film> findWorkToAdd(Integer actorId);

    public int insertWorkForActor(Integer filmId,Integer actorId);

    public int insertActor(Actor actor);

    /**
     * 找出电影的演员
     * @param filmId
     * @return
     */
    public List<Actor> selectActorsForFilm(Integer filmId);
}
