<!DOCTYPE html>
<html lang="en">
    <head>
        <title><#if artist??>${artist["name"]}</#if></title>
        <#include "head.ftl">
    </head>

    <body>
        <#include "navbar.ftl">
        <div class="container">
            <#if artist??>
                <h1>${artist["name"]}</h1>
                <img src=
                    <#if artist["images"]?has_content>
                        "${artist["images"][1]}"
                    <#else>
                        "/images/blank_profile_pic.png"
                    </#if>
                class="artist-preview">

                <br>
                <br>
                <h2>Genres</h2>
                <#if artist["genres"]??>
                    <table>
                        <tr>
                        <#list artist["genres"] as genre>
                            <a href="/search?type=artist&genre=${genre}&page=1" class="tag">${genre}</a>
                        </#list>
                        </tr>
                    </table>
                </#if>


                <h2>Albums</h2>
                <table>
                <#list artist["albums"] as album>
                    <tr>
                        <td rowspan="2" style="width: 200px;">
                            <a class="btn" data-toggle="collapse" data-target="#collapsedAlbum${album?index}" style="padding: 6px 0px;">
                                <#if album["image"]??>
                                    <img src="${album["image"]}" class="album-image">
                                </#if>
                            </a>
                        </td>
                        <td>
                            <span>&nbsp;</span>
                            <a href="${album["uri"]}">
                                ${album["title"]}
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>&nbsp;</span>
                            ${album["year"]?c}
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                        <div id="collapsedAlbum${album?index}" aria-expanded="true" style="" class="panel panel-default collapse">

                            <ol class="list-group">
                                <#list album["songs"] as song>
                                    <a class="list-group-item" href="${song["uri"]}">
                                        ${song["title"]} - ${(song["duration"]/60)?int}:<#if (song["duration"]%60)?int < 10>0</#if>${song["duration"]%60}
                                    </a>
                                </#list>

                            </ol>
                        </div>
                        </td>
                    </tr>
                </#list>
                </table>

            </#if>
        </div>

        <#include "javascript.ftl">
    </body>

</html>