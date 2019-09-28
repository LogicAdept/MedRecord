package com.samsolutions.converter;

import com.samsolutions.dto.data.VisitDataDTO;
import com.samsolutions.dto.form.VisitFormDTO;
import com.samsolutions.entity.Visit;
import com.samsolutions.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class VisitConverter implements DTOConverter<Visit, VisitDataDTO, VisitFormDTO> {

    @Autowired
    TicketConverter ticketConverter;

    @Autowired
    TicketRepository ticketRepository;

    @Override
    public VisitDataDTO entityToDataDto(Visit source) {
        VisitDataDTO target = new VisitDataDTO();
        target.setId(source.getId());
        target.setTicket(ticketConverter.entityToDataDto(source.getTicket()));
        target.setDatetime(source.getDatetime());
        target.setComplaint(source.getComplaint());
        target.setExamination(source.getExamination());
        target.setDiagnosis(source.getDiagnosis());
        target.setTreatment(source.getTreatment());
        return target;
    }

    @Override
    public Visit formDtoToEntity(VisitFormDTO source) {
        Visit target = new Visit();
        target.setId(source.getId());
        target.setTicket(ticketRepository.getOne(source.getTicketId()));
        target.setDatetime(LocalDateTime.parse(source.getDatetime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        target.setComplaint(source.getComplaint());
        target.setExamination(source.getExamination());
        target.setDiagnosis(source.getDiagnosis());
        target.setTreatment(source.getTreatment());
        return target;
    }

    @Override
    public Set<VisitDataDTO> entitiesToDataDtoSet(Set<Visit> sourceSet) {
        Set<VisitDataDTO> targetSet = new HashSet<>();
        for (Visit source : sourceSet) {
            VisitDataDTO target = entityToDataDto(source);
            targetSet.add(target);
        }
        return targetSet;
    }

    @Override
    public List<VisitDataDTO> entitiesToDataDtoList(List<Visit> sourceList) {
        List<VisitDataDTO> targetList = new ArrayList<>();
        for (Visit source : sourceList) {
            VisitDataDTO target = entityToDataDto(source);
            targetList.add(target);
        }
        return targetList;
    }

    @Override
    public Set<Visit> formDtoSetToEntities(Set<VisitFormDTO> sourceSet) {
        Set<Visit> targetSet = new HashSet<>();
        for (VisitFormDTO source : sourceSet) {
            Visit target = formDtoToEntity(source);
            targetSet.add(target);
        }
        return targetSet;
    }
}
