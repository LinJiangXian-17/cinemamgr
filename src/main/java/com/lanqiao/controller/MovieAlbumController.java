package com.lanqiao.controller;

import com.lanqiao.entity.MovieAlbum;
import com.lanqiao.service.IMovieAlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/album")
public class MovieAlbumController {

    @Autowired
    IMovieAlbumService movieAlbumService;

    @RequestMapping("/addImgages")
    @ResponseBody
    public String addImagesForFilm(HttpServletRequest request){

        String _filmId = request.getParameter("filmId");
        String[] imgUrls = request.getParameterValues("imgUrl");

        Integer filmId = null;

        if (_filmId != null){
            filmId = Integer.valueOf(_filmId);
        }

        int j = 0;

        if (imgUrls != null && filmId != null){
            for (int i = 0; i < imgUrls.length; i++) {
                j += this.movieAlbumService.insertImgagesForFilm(filmId,imgUrls[i]);
            }
        }

        if (j > 0){
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    @RequestMapping("/findImagesForFilm")
    @ResponseBody
    public List<MovieAlbum> findImagesForFilm(Integer filmId){
        List<MovieAlbum> movieAlbums = this.movieAlbumService.selectImages(filmId);
        return movieAlbums;
    }
}
