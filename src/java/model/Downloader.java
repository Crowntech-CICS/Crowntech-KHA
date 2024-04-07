/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpRequest.Builder;
import java.net.http.HttpResponse.BodyHandlers;
import java.nio.file.Files;
import java.nio.file.Path;

public class Downloader {
    public static void download(String url) {
        final HttpClient hc = HttpClient.newHttpClient();
        final Builder requestBuilder = HttpRequest.newBuilder().version(HttpClient.Version.HTTP_1_1);
        
        Path path = Path.of("myfilepath");
        handleGet(hc, "myfile.pdf", "myurl.com", path, requestBuilder);
        
    }

    private static void handleGet(
                final HttpClient hc, 
                final String fileName, 
                final String url,
                final Path filePath, 
                final Builder requestBuilder
                ) {
            
            final HttpRequest request = requestBuilder.uri(URI.create(url)).build();
            hc.sendAsync(request, BodyHandlers.ofInputStream())
            .thenApply(resp -> {
                int sc = resp.statusCode();
                System.out.println("STATUSCODE: "+sc+" for url '"+url+"'");
                if(sc >= 200 && sc < 300) return resp;
                if(sc == 302) {                 
                    System.out.println("Handling 302...");
                    String newUrl = resp.headers().firstValue("location").get();
                    
                    handleGet(hc, fileName, newUrl, filePath, requestBuilder);
                }
                return resp;
            })
            .thenAccept(resp -> {
                int sc = resp.statusCode();
                if(sc >= 200 && sc < 300) {                 
                    try {
                        System.out.println("Im fine here");
                        Files.copy(resp.body(), filePath);
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    System.err.println("STATUSCODE: "+ sc +" for file "+ fileName);
                }
            }).join();
        }
}
