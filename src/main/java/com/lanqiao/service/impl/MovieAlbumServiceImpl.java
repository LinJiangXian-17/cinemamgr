package com.lanqiao.service.impl;

import com.lanqiao.entity.MovieAlbum;
import com.lanqiao.mapper.MovieAlbumMapper;
import com.lanqiao.service.IMovieAlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("movieAlbumService")
public class MovieAlbumServiceImpl implements IMovieAlbumService {

    @Autowired
    MovieAlbumMapper movieAlbumMapper;

    @Override
    public int insertImgagesForFilm(Integer filmId, String imgUrl) {
        return this.movieAlbumMapper.insertImgagesForFilm(filmId,imgUrl);
    }

    @Override
    public List<MovieAlbum> selectImages(Integer filmId) {
        return this.movieAlbumMapper.selectImages(filmId);
    }
}
