package com.samsolutions.service.impl;

import com.samsolutions.converter.TicketConverter;
import com.samsolutions.converter.UserConverter;
import com.samsolutions.converter.VisitConverter;
import com.samsolutions.dto.TicketDTO;
import com.samsolutions.dto.VisitDTO;
import com.samsolutions.entity.Visit;
import com.samsolutions.repository.VisitRepository;
import com.samsolutions.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Implements the methods defined in the visit service.
 *
 * @author Vladislav Brazovskij <u.brazouski@sam-solutions.com>
 * @package com.samsolutions.service.impl
 * @link http ://sam-solutions.com/
 * @copyright 2019 SaM
 */

@Service
public class VisitServiceImpl implements VisitService {

    @Autowired
    private VisitRepository visitRepository;

    @Autowired
    private VisitConverter visitConverter;

    @Autowired
    private TicketConverter ticketConverter;

    @Autowired
    UserConverter userConverter;

    @Override
    public void save(final VisitDTO visitDTO) {
        Visit visit = visitConverter.dtoToEntity(visitDTO);
        visitRepository.save(visit);
    }

    @Override
    public void delete(final Long id) {
        visitRepository.deleteById(id);
    }


    @Override
    public VisitDTO findById(final Long id) {
        return visitConverter.entityToDTO(visitRepository.getOne(id));
    }

    @Override
    public VisitDTO findByTicket(TicketDTO ticketDTO) {
        return visitConverter.entityToDTO(visitRepository.findVisitByTicket(ticketConverter.dtoToEntity(ticketDTO)));
    }
}
