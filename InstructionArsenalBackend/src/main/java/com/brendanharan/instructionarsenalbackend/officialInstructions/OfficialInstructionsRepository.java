/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsRepository.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;


import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Repository @Transactional(readOnly = true)
public interface OfficialInstructionsRepository extends JpaRepository<OfficialInstructions, Long> {


    @Query(value = "SELECT o1_0 FROM OfficialInstructions o1_0 WHERE o1_0.title LIKE %:title%", nativeQuery = false)
    List<OfficialInstructions> findByTitleLikeIgnoreCase(String title);

    @Query(value = "SELECT o1_0 FROM OfficialInstructions o1_0 WHERE o1_0.title LIKE %:title% AND o1_0.company LIKE %:company%", nativeQuery = false)
    List<OfficialInstructions> findAllByTitleAndCompanyLikeIgnoreCase(String title, String company, Pageable pageable);

    OfficialInstructions findAllById(Long id);

    @Query(value = "SELECT o1_0 FROM OfficialInstructions o1_0 WHERE o1_0.createdBy LIKE %:createdBy%", nativeQuery = false)
    List<OfficialInstructions> findAllByCreatedByLikeIgnoreCase(String createdBy);

    @Query(value = "SELECT o1_0 FROM OfficialInstructions o1_0 WHERE o1_0.company LIKE %:company%", nativeQuery = false)
   List<OfficialInstructions> findAllByCompanyLikeIgnoreCase(String company);


    List<OfficialInstructions> findAllByCreatedBy(String createdBy);
}
