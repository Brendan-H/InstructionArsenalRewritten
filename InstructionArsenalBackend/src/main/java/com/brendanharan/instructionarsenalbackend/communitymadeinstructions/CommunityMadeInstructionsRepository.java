/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructionsRepository.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.communitymadeinstructions;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Repository @Transactional(readOnly = true)
public interface CommunityMadeInstructionsRepository extends JpaRepository<CommunityMadeInstructions, Long> {


    @Query(value = "SELECT o1_0 FROM CommunityMadeInstructions o1_0 WHERE o1_0.title LIKE %:title%", nativeQuery = false)
    List<CommunityMadeInstructions> findByTitleLikeIgnoreCase(String title);

    CommunityMadeInstructions findAllById(Long id);

    //List<CommunityMadeInstructions> findAll(Pageable pageable);

    @Query(value = "SELECT o1_0 FROM CommunityMadeInstructions o1_0 WHERE o1_0.title LIKE %:title% AND o1_0.category LIKE %:category%", nativeQuery = false)
    List<CommunityMadeInstructions> findAllByTitleAndCategoryLikeIgnoreCase(String title, String category, Pageable pageable);

    List<CommunityMadeInstructions> findAllByCreatedBy(String createdBy);

    @Modifying
    @Transactional
    @Query(value = "UPDATE CommunityMadeInstructions SET likes = likes + 1 WHERE id = :id")
    void setLikes(long id);
}