package com.lanqiao.controller;

import com.lanqiao.entity.Cinema;
import com.lanqiao.entity.Film;
import com.lanqiao.service.ICinemaService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cinema")
public class CinemaController {

    @Autowired
    ICinemaService cinemaService;

    @RequestMapping("/all")
    public String findAllCinema(Cinema condition, Integer pageNum, ModelMap modelMap, HttpSession session){

        //表示用户点击查询按钮
        if (pageNum == null) {
            //保留查询条件
            session.setAttribute("cinemaCondition",condition);
            pageNum = 1;
        } else {
            //表示用户点击的是分页链接，则将原来保存的查询条件从session中取出
            condition = (Cinema) session.getAttribute("cinemaCondition");
        }

        List<Cinema> cinemas = this.cinemaService.findAll(condition, pageNum, 4);
        modelMap.addAttribute("page", (com.github.pagehelper.Page<Cinema>)cinemas);

        return "cinema_list";
    }

    @RequestMapping("/showAll")
    @ResponseBody
    public List<Cinema> showAllCinema(Cinema condition, Integer pageNum, ModelMap modelMap, HttpSession session){

        //表示用户点击查询按钮
        if (pageNum == null) {
            //保留查询条件
            session.setAttribute("cinemaCondition",condition);
            pageNum = 1;
        } else {
            //表示用户点击的是分页链接，则将原来保存的查询条件从session中取出
            condition = (Cinema) session.getAttribute("cinemaCondition");
        }

        List<Cinema> cinemas = this.cinemaService.findAll(condition, pageNum, 10);
        //modelMap.addAttribute("page", (com.github.pagehelper.Page<Cinema>)cinemas);

        return cinemas;
    }

    @RequestMapping("/findById")
    @ResponseBody
    public Cinema findById(Integer cinemaId){

        Cinema cinema = this.cinemaService.findCinemaById(cinemaId);
        return cinema;
    }

    @RequestMapping("/updateCinema")
    @ResponseBody
    public String updateCinemaInfo(Cinema cinema){
        int i = this.cinemaService.updateCinema(cinema);
        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    @RequestMapping("/addCinema")
    @ResponseBody
    public String addCinemaInfo(Cinema cinema){

        int i = this.cinemaService.insertCinema(cinema);
        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    /**
     * 查找未上架的电影
     * @param cinemaId
     * @return
     */
    @RequestMapping("/findFilm")
    @ResponseBody
    public List<Film> findFilmByCinemaId(Integer cinemaId){
        List<Film> filmList = this.cinemaService.findFilmByCinemaId(cinemaId);
        return filmList;
    }

    /**
     * 电影上架
     * @param request
     * @return
     */
    @RequestMapping("/onShelves")
    @ResponseBody
    public String moviesOnTheShelves(HttpServletRequest request){

        String[] _filmIds = request.getParameterValues("filmId");
        String _cinemaId = request.getParameter("cinemaId");

        Integer[] filmIds = null;
        Integer cinemaId = null;

        if (StringUtils.isNotBlank(_cinemaId)) {
            cinemaId = Integer.valueOf(_cinemaId);
        }

        if (_filmIds != null) {
            filmIds = new Integer[_filmIds.length];
            for (int i = 0; i < _filmIds.length; i++) {
                filmIds[i] = Integer.valueOf(_filmIds[i]);
            }
        }

        int i = 0;

        /*
        *效率极低
        */
        if (cinemaId != null && filmIds != null){
            for (int j = 0; j < filmIds.length; j++) {
                i += this.cinemaService.insertFilmIntoCinema(cinemaId, filmIds[j]);
            }
        }

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }


    /**
     * 查询已上架的电影
     * @param cinemaId
     * @return
     */
    @RequestMapping("/searchFilm")
    @ResponseBody
    public List<Film> searchFilm(Integer cinemaId){
        List<Film> filmOnShelves = this.cinemaService.findFilmOnShelves(cinemaId);
        return filmOnShelves;
    }

    @RequestMapping("/offShelves")
    @ResponseBody
    public String offShelves(HttpServletRequest request){
        String[] _filmIds = request.getParameterValues("filmId");
        String _cinemaId = request.getParameter("cinemaId");

        Integer[] filmIds = null;
        Integer cinemaId = null;

        if (StringUtils.isNotBlank(_cinemaId)) {
            cinemaId = Integer.valueOf(_cinemaId);
        }

        if (_filmIds != null) {
            filmIds = new Integer[_filmIds.length];
            for (int i = 0; i < _filmIds.length; i++) {
                filmIds[i] = Integer.valueOf(_filmIds[i]);
            }
        }

        int i = 0;

        /*
         *效率极低
         */
        if (cinemaId != null && filmIds != null){
            for (int j = 0; j < filmIds.length; j++) {
                i += this.cinemaService.delFilmFromCinema(cinemaId, filmIds[j]);
            }
        }

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }
}
