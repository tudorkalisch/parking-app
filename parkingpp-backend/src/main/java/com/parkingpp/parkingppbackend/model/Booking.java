package com.parkingpp.parkingppbackend.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "booking")
public class Booking {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator"
    )
    UUID id;
    @ManyToOne
    @JoinColumn(name = "location_id")
    Location location;
    UUID userId;
    long startTime;
    long endTime;
    @Column(length = 1500000)
    String qr;

    public Booking() {
    }

    public Booking(@JsonProperty("id") UUID id, @JsonProperty("user_id") UUID userId, @JsonProperty("startTime") long startTime, @JsonProperty("endTime") long endTime, @JsonProperty("location") Location location, @JsonProperty("qr") String qr) {
        this.id = id;
        this.userId = userId;
        this.location = location;
        this.startTime = startTime;
        this.endTime = endTime;
        this.qr = qr;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public long getStartTime() {
        return startTime;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    public long getEndTime() {
        return endTime;
    }

    public void setEndTime(long endTime) {
        this.endTime = endTime;
    }

    public String getQR() {
        return qr;
    }

    public void setQR(String qr) {
        this.qr = qr;
    }
}

