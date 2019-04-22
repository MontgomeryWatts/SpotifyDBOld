package com.spotifydb.ui.controllers;

import com.spotifydb.model.Preview;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.spotifydb.application.DatabaseService;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

import static com.spotifydb.model.db.implementations.DatabaseConnection.RESULTS_PER_PAGE;


@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private DatabaseService service;

    @GetMapping("")
    public String searchGet(Model model, @RequestParam(required = false) String type,
                            @RequestParam(required = false) String name,
                            @RequestParam(required = false) String genre,
                            @RequestParam(required = false) Integer year,
                            @RequestParam(required = false, defaultValue = "1") Integer page){

        model.addAttribute("title", "Search - SpotifyDB");

        if (type != null){
            List<Preview> previews = null;
            boolean hasNext = false;
            int offset;
            switch (type){
                case "artist":
                    offset = RESULTS_PER_PAGE * (page - 1);
                    previews = service.getArtists(genre, name, offset, RESULTS_PER_PAGE);
                    hasNext = service.getNumArtistsBy(genre, name) > previews.size() + RESULTS_PER_PAGE * (page -1);
                    break;
                case "album":
                    offset = RESULTS_PER_PAGE * (page - 1);
                    previews = service.getAlbums(name, year, offset, RESULTS_PER_PAGE);
                    hasNext = service.getNumAlbumsBy(name, year) > previews.size() + RESULTS_PER_PAGE * (page -1);
                default:
                    break;
            }

            if (previews != null){
                model.addAttribute("results", previews);
                model.addAttribute("page", page);


                boolean hasPrev = page >= 2 && previews.size() > 0;
                if (hasPrev){
                    String prevLink = getPaginationLink( page - 1);
                    model.addAttribute("prevLink", prevLink);
                    model.addAttribute("hasPrev", true);
                }

                if (hasNext){
                    String nextLink = getPaginationLink(page + 1);
                    model.addAttribute("nextLink", nextLink);
                    model.addAttribute("hasNext", true);
                }


                return "results";
            }
        }

        return "search";
    }

    private static String getPaginationLink(int page){
        ServletUriComponentsBuilder builder = ServletUriComponentsBuilder.fromCurrentRequest();
        //builder.scheme("https");
        builder.replaceQueryParam("page", page);
        return builder.build().toString();
    }

}
