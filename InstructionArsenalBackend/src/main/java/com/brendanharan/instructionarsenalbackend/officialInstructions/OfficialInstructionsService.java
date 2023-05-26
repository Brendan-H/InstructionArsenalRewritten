/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (OfficialInstructionsService.java) Last Modified on 1/13/23, 6:46 PM
 *
 */

package com.brendanharan.instructionarsenalbackend.officialInstructions;


import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service @AllArgsConstructor
public class OfficialInstructionsService {

    @Autowired
    private OfficialInstructionsRepository officialInstructionsRepository;



    public List<OfficialInstructions> findOfficialInstructionsByTitleLike(String title) {
        return officialInstructionsRepository.findByTitleLikeIgnoreCase(title);
    }
    public List<OfficialInstructions> findOfficialInstructionsByTitleAndCompanyLike(String title, String company, Integer pageNo, Integer pageSize) {
        return officialInstructionsRepository.findAllByTitleAndCompanyLikeIgnoreCase(title, company, PageRequest.of(pageNo, pageSize));
    }

    public void saveOfficialInstructions(OfficialInstructions officialInstructions) {
        officialInstructionsRepository.save(officialInstructions);
    }

    public void deleteOfficialInstructions(Long id) {
        officialInstructionsRepository.deleteById(id);
    }

    public List<OfficialInstructions> getOfficialInstructions(){
        return officialInstructionsRepository.findAll();
    }


    public OfficialInstructions findOfficialInstructionsByID(Long id) {
        return officialInstructionsRepository.findAllById(id);
    }

    public List<OfficialInstructions> findOfficialInstructionsByCreatedBy(String createdBy) {
        return officialInstructionsRepository.findAllByCreatedByLikeIgnoreCase(createdBy);
    }

    public List<OfficialInstructions> findOfficialInstructionsByCompany(String company) {
        return officialInstructionsRepository.findAllByCompanyLikeIgnoreCase(company);
    }

    public List<OfficialInstructions> findOfficialInstructionsByCreatedByExact(String createdBy) {
        return officialInstructionsRepository.findAllByCreatedBy(createdBy);
    }
}

