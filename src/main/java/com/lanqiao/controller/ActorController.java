package com.lanqiao.controller;

import com.lanqiao.entity.Actor;
import com.lanqiao.entity.Film;
import com.lanqiao.service.IActorService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/actor")
public class ActorController {

    @Autowired
    IActorService actorService;


    /**
     * 按条件查询演员
     * @param condition
     * @param pageNum
     * @param modelMap
     * @param session
     * @return
     */
    @RequestMapping("/all")
    public String findAllActors(Actor condition,Integer pageNum,ModelMap modelMap, HttpSession session){

        if (pageNum == null) {
            pageNum = 1;
            session.setAttribute("condition",condition);

        } else {
            condition = (Actor) session.getAttribute("condition");
        }

        List<Actor> actors = this.actorService.findAll(condition, pageNum, 20);

        modelMap.addAttribute("page", (com.github.pagehelper.Page<Actor>)actors);

        return "actor_list";
    }

    /**
     * 查询作品
     * @param actorId
     * @return
     */
    @RequestMapping("/findWork")
    @ResponseBody
    public List<Film> findWork(Integer actorId){
        List<Film> works = this.actorService.findWorkToAdd(actorId);
        return works;
    }

    /**
     * 为演员添加作品
     * @param request
     * @return
     */
    @RequestMapping("/addWork")
    @ResponseBody
    public String addWorkForActor(HttpServletRequest request){

        String[] _filmIds = request.getParameterValues("filmId");
        String _actorId = request.getParameter("actorId");

        Integer[] filmIds = null;
        Integer actorId = null;

        if (StringUtils.isNotBlank(_actorId)) {
            actorId = Integer.valueOf(_actorId);
        }

        if (_filmIds != null) {
            filmIds = new Integer[_filmIds.length];
            for (int i = 0; i < _filmIds.length; i++) {
                filmIds[i] = Integer.valueOf(_filmIds[i]);
            }
        }

        int i = 0;

        if (actorId != null && filmIds != null){
            for (int j = 0; j < filmIds.length; j++) {
                i += this.actorService.insertWorkForActor(filmIds[j], actorId);
            }
        }

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    /**
     * 添加演员
     * @param actor
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public String saveActor(Actor actor){
        int i = this.actorService.insertActor(actor);

        if (i>0) {
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    @RequestMapping("/findActors")
    @ResponseBody
    public List<Actor> findActorsForFilm(Integer filmId){
        List<Actor> actors = this.actorService.selectActorsForFilm(filmId);
        return actors;
    }
}
