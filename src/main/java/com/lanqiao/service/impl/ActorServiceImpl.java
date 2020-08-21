package com.lanqiao.service.impl;

import com.lanqiao.entity.Actor;
import com.lanqiao.entity.Film;
import com.lanqiao.mapper.ActorMapper;
import com.lanqiao.service.IActorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActorServiceImpl implements IActorService {

    @Autowired
    ActorMapper actorMapper;

    @Override
    public List<Actor> findAll(Actor actor, int pageNum, int pageSize) {
        return this.actorMapper.findAll(actor, pageNum, pageSize);
    }

    /**
     * 查询该演员为参演的作品
     *
     * @param actorId
     * @return
     */
    @Override
    public List<Film> findWorkToAdd(Integer actorId) {
        return this.actorMapper.findWorkToAdd(actorId);
    }

    @Override
    public int insertWorkForActor(Integer filmId, Integer actorId) {
        return this.actorMapper.insertWorkForActor(filmId, actorId);
    }

    @Override
    public int insertActor(Actor actor) {
        return this.actorMapper.insertActor(actor);
    }

    /**
     * 找出电影的演员
     *
     * @param filmId
     * @return
     */
    @Override
    public List<Actor> selectActorsForFilm(Integer filmId) {
        return this.actorMapper.selectActorsForFilm(filmId);
    }
}
