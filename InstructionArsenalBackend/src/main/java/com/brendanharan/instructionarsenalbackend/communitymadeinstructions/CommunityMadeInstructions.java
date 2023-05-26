/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructions.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @Entity
public class CommunityMadeInstructions {

    @SequenceGenerator(
            name = "community_made_instructions_sequence",
            sequenceName = "community_made_instructions_sequence",
            allocationSize = 1
    )
    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "community_made_instructions_sequence"
    )
    private Long id;

    @Column(name="Title", length = 512)
    private String title;

    @Column(name = "Description", length = 2048)
    private String description;

    @Column(name="PostCreatedAt")
    private LocalDateTime postCreatedAt = LocalDateTime.now();

    @Lob
    @Column(name="Instructions")
    private String instructions;

    @Column(name="CreatedBy")
    private String createdBy;

    @Column(name="Category")
    private String category;

    @Column(name="Likes")
    private int likes;

    @Column(name="Dislikes")
    private int dislikes;

    @Column(name="Tags")
    private String tags;

    @Column(name="Difficulty")
    private int difficulty;

    @Column(name="TimeToComplete")
    private String timeToComplete;

    @Column(name="IsSponsored")
    private boolean isSponsored;


//    @Column(name="ImageURL")
//    private String imageURL;
//TODO add file storage (probably with google cloud storage)


    @Override
    public String toString() {
        return "CommunityMadeInstructions{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", postCreatedAt=" + postCreatedAt +
                ", instructions='" + instructions + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", category='" + category + '\'' +
                ", likes=" + likes +
                ", dislikes=" + dislikes +
                ", tags='" + tags + '\'' +
                ", difficulty='" + difficulty + '\'' +
                ", timeToComplete='" + timeToComplete + '\'' +
                ", isSponsored=" + isSponsored +
                '}';
    }

    public CommunityMadeInstructions(String title, String description,
                                     LocalDateTime postCreatedAt, String instructions,
                                     String createdBy, String category,
                                     int likes, int dislikes, String tags, int difficulty,
                                     String timeToComplete, boolean isSponsored) {
        this.title = title;
        this.description = description;
        this.postCreatedAt = postCreatedAt;
        this.instructions = instructions;
        this.createdBy = createdBy;
        this.category = category;
        this.likes = likes;
        this.dislikes = dislikes;
        this.tags = tags;
        this.difficulty = difficulty;
        this.timeToComplete = timeToComplete;
        this.isSponsored = isSponsored;
    }
}
