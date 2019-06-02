<!DOCTYPE html>
<html lang="en">
<head>
    <title><#if artist??>${artist["album"]["title"]}</#if></title>
        <#include "head.ftl">
</head>

<body>
        <#include "navbar.ftl">
            <div class="container">
                <#if artist??>
                    <div class="row">
                        <#assign album=artist["album"]>

                        <div class="media">
                            <img src="${album["image"]}" class="album-image pull-left">

                            <h1>${album["title"]}</h1>
                            <p>By
                                <#list artist["credits"] as credit>
                                    <a href="/artists/${credit["artistId"]}">
                                        ${credit["name"]}<#sep>,
                                    </a>
                                </#list>
                            </p>
                        </div>

                        <br>


                        <#list album["songs"] as song>
                           <a class="list-group-item text-center" href="spotify:track:${song["trackId"]}">
                               <small class="pull-left">
                                   ${song?index + 1}
                               </small>

                               ${song["title"]}

                               <small class="pull-right">
                                   ${(song["duration"]/60)?int}:<#if (song["duration"]%60)?int < 10>0</#if>${song["duration"]%60}
                               </small>
                           </a>
                        </#list>
                    </div>
                </#if>
            </div>

        <#include "javascript.ftl">
</body>

</html>