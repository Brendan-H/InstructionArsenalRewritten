/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructions.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;

import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @Entity
public class OfficialInstructions {

    @SequenceGenerator(
            name = "official_instructions_sequence",
            sequenceName = "official_instructions_sequence",
            allocationSize = 1
    )
    @Id
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "official_instructions_sequence"
    )
    private Long id;

    @Column(name="Title", length = 512)
    private String title;

    @Column(name = "Description", length = 2048)
    private String description;

    @Column(name="Company")
    private String company;

    @Column(name="PostCreatedAt")
    private LocalDateTime postCreatedAt = LocalDateTime.now();

    @Lob
    @Column(name="Instructions")
    private String instructions;

    @Column(name="CreatedBy")
    private String createdBy;

//    @Lob
//    @Column(name = "file")
//    private byte[] file;
//TODO add file storage


    @Override
    public String toString() {
        return "CommunityMadeInstructions{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", company='" + company + '\'' +
                ", postCreatedAt=" + postCreatedAt +
                ", instructions='" + instructions + '\'' +
                ", createdBy='" + createdBy + '\'' +
                '}';
    }

    public OfficialInstructions(String title, String description, String company, LocalDateTime postCreatedAt, String instructions, String createdBy) {
        this.title = title;
        this.description = description;
        this.company = company;
        this.postCreatedAt = postCreatedAt;
        this.instructions = instructions;
        this.createdBy = createdBy;
    }
}
