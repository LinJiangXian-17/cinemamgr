package com.lanqiao.service;

import com.lanqiao.entity.MovieAlbum;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMovieAlbumService {
    public int insertImgagesForFilm(Integer filmId, String imgUrl);

    public List<MovieAlbum> selectImages(Integer filmId);
}
