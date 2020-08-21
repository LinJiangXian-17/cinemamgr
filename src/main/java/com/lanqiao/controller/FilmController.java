package com.lanqiao.controller;

import com.lanqiao.entity.Film;
import com.lanqiao.service.IFilmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/film")
public class FilmController {

    @Autowired
    IFilmService filmService;

    /**
     * 查询正在热映
     * @param condition
     * @param pageNum
     * @param modelMap
     * @param session
     * @return
     */
    @RequestMapping("/all")
    public String findAll(Film condition, Integer pageNum, ModelMap modelMap, HttpSession session){
        //表示用户点击查询按钮
        if (pageNum == null) {
            //保留查询条件
            session.setAttribute("condition",condition);
            pageNum = 1;
        } else {
            //表示用户点击的是分页链接，则将原来保存的查询条件从session中取出
            condition = (Film) session.getAttribute("condition");
        }

        List<Film> films = this.filmService.selectAll(condition, pageNum, 6);
        modelMap.addAttribute("page", (com.github.pagehelper.Page<Film>)films);

        return "film_list";
    }

    /**
     * 即将上映
     * @param condition
     * @param pageNum
     * @param modelMap
     * @param session
     * @return
     */
    @RequestMapping("/upComing")
    public String findUpComing(Film condition, Integer pageNum, ModelMap modelMap, HttpSession session){
        //表示用户点击查询按钮
        if (pageNum == null) {
            //保留查询条件
            session.setAttribute("condition",condition);
            pageNum = 1;
        } else {
            //表示用户点击的是分页链接，则将原来保存的查询条件从session中取出
            condition = (Film) session.getAttribute("condition");
        }

        List<Film> films = this.filmService.selectAllUpComing(condition, pageNum, 6);
        modelMap.addAttribute("page", (com.github.pagehelper.Page<Film>)films);

        return "upcoming_list";
    }

    /**
     * 热播电影
     * @param condition
     * @param pageNum
     * @param modelMap
     * @param session
     * @return
     */
    @RequestMapping("/hit")
    public String findHit(Film condition, Integer pageNum, ModelMap modelMap, HttpSession session){
        //表示用户点击查询按钮
        if (pageNum == null) {
            //保留查询条件
            session.setAttribute("condition",condition);
            pageNum = 1;
        } else {
            //表示用户点击的是分页链接，则将原来保存的查询条件从session中取出
            condition = (Film) session.getAttribute("condition");
        }

        List<Film> films = this.filmService.selectAllHit(condition, pageNum, 6);
        modelMap.addAttribute("page", (com.github.pagehelper.Page<Film>)films);

        return "hit_list";
    }

    @RequestMapping("/findByFilmId")
    @ResponseBody
    public Film findByFilmId(Integer filmId){
        Film film = this.filmService.selectById(filmId);
        return film;
    }

    /**
     * 更新电影信息
     * @param film
     * @return
     */
    @RequestMapping("/UpdateFilm")
    @ResponseBody
    public String UpdateFilm(Film film){

        int i = this.filmService.updateFilm(film);

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    /**
     * 插入电影
     * @param film
     * @return
     */
    @RequestMapping("/insertFilm")
    @ResponseBody
    public String insertFilm(Film film){

        int i = this.filmService.insertFilm(film);

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }


    /**
     * 把正在热映移到热播电影 或者 把即将上映移到正在热映
     * @param filmId
     * @param score
     * @return
     */
    @RequestMapping("/moveToHit")
    @ResponseBody
    public String moveToHit(Integer filmId,Double score){
        int i = this.filmService.updateToHit(filmId, score);
        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }
}
