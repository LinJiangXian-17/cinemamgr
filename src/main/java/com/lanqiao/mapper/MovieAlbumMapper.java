package com.lanqiao.mapper;

import com.lanqiao.entity.MovieAlbum;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieAlbumMapper {
    public int insertImgagesForFilm(@Param("filmId") Integer filmId, @Param("imgUrl")String imgUrl);

    public List<MovieAlbum> selectImages(Integer filmId);
}
