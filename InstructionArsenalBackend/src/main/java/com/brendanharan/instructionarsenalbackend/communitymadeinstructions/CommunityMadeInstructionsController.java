/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructionsController.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/v1/instructions/communitymadeinstructions")
@AllArgsConstructor
public class CommunityMadeInstructionsController {


    private final CommunityMadeInstructionsService communityMadeInstructionsService;

    @PostMapping()
    public ResponseEntity createPost(@RequestBody CommunityMadeInstructions communityMadeInstructions)  {
        communityMadeInstructionsService.saveCommunityMadeInstructions(communityMadeInstructions);
        return new ResponseEntity(HttpStatus.CREATED);
    }

    @GetMapping("/all")
    public ResponseEntity<List<CommunityMadeInstructions>> getPosts(@RequestParam(defaultValue = "0") Integer pageNo, @RequestParam(defaultValue = "10") Integer pageSize) {
        return ResponseEntity.ok().body(communityMadeInstructionsService.getCommunityMadeInstructions(pageNo, pageSize));
    }

    @GetMapping("/{id}")
    CommunityMadeInstructions findPostByID(@PathVariable Long id) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByID(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity deletePostByID(@PathVariable Long id) {
        communityMadeInstructionsService.deleteCommunityMadeInstructions(id);
        return ResponseEntity.ok("Community-Made Instruction Deleted");
    }

    @GetMapping("/title/{title}")
    List<CommunityMadeInstructions> findPostByTitle(@PathVariable String title) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByTitleLike(title);
    }


    @GetMapping("/createdbyexact/{createdBy}")
    List<CommunityMadeInstructions> findPostByCreatedByExact(@PathVariable String createdBy) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByCreatedByExact(createdBy);
    }

    @GetMapping("/titleandcategory/{title}/{category}")
    List<CommunityMadeInstructions> findPostByTitleAndCategory(@PathVariable String title, @PathVariable String category, @RequestParam(defaultValue = "0") Integer pageNo, @RequestParam(defaultValue = "10") Integer pageSize) {
        return communityMadeInstructionsService.findCommunityMadeInstructionsByTitleAndCategoryLike(title, category, pageNo, pageSize);
    }

    @PutMapping("/likepost/{id}")
    ResponseEntity likePost(@PathVariable long id) {
        communityMadeInstructionsService.likeCommunityMadeInstructions(id);
       return ResponseEntity.ok("Post Liked");
    }

    @GetMapping("/getlikes/{id}")
    int getLikes(@PathVariable long id) {
        return communityMadeInstructionsService.getLikes(id);
    }



}