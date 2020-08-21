package com.lanqiao.controller;

import com.lanqiao.entity.Figure;
import com.lanqiao.service.IFigureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/figure")
public class FigureController {

    @Autowired
    IFigureService figureService;


    @RequestMapping("/all")
    public String findAddFigure(Figure condition,Integer pageNum ,ModelMap modelMap, HttpSession session){

        if ( pageNum == null) {
            pageNum = 1;
            session.setAttribute("condition",condition);

        } else {
            condition = (Figure)session.getAttribute("condition");
        }

        List<Figure> allFigure = this.figureService.findAllFigure(condition, pageNum, 6);

        modelMap.addAttribute("page", (com.github.pagehelper.Page<Figure>)allFigure);

        return "figure_list";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String saveFigure(Figure figure){
        int i = this.figureService.insertFigure(figure);
        if (i > 0){
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }

    @RequestMapping("/del")
    @ResponseBody
    public String deleteFigureById(Integer figureId){
        int i = this.figureService.deleteFigureById(figureId);
        if (i > 0){
            return "{\"resultCode\": true}";
        }
        return "{\"resultCode\": false}";
    }
}
