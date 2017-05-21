
# TODO:
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.

from __future__ import unicode_literals

from django.db import models


class Report(models.Model):
    title = models.CharField(max_length=50)
    pub_date = models.DateField()
    headline = models.CharField(max_length=200)
    content = models.TextField()

    def __str__(self):
        return self.title


class ExoObjectsHasStars(models.Model):
    exo_objects = models.ForeignKey('ExoObjects', models.DO_NOTHING, db_column='EXO-OBJECTS_ID')  # Field name made lowercase. Field renamed to remove unsuitable characters.
    stars = models.ForeignKey('Vsx', models.DO_NOTHING, db_column='STARS_ID')  # Field name made lowercase.
    stars_star_name = models.CharField(db_column='STARS_Star_Name', max_length=11)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'EXO-OBJECTS_has_STARS'
        unique_together = (('exo_objects', 'stars', 'stars_star_name'),)


class ExoObjects(models.Model):
    object_id = models.CharField(max_length=45)
    type = models.IntegerField(db_column='Type')  # Field name made lowercase.
    epoch = models.DecimalField(db_column='Epoch', max_digits=16, decimal_places=9)  # Field name made lowercase.
    epoch_time_standard = models.CharField(db_column='Epoch_Time_Standard', max_length=7)  # Field name made lowercase.
    period = models.DecimalField(db_column='Period', max_digits=9, decimal_places=6)  # Field name made lowercase.
    transit_duration = models.DecimalField(db_column='Transit_Duration', max_digits=7, decimal_places=6)  # Field name made lowercase.
    orbit_inclination = models.DecimalField(db_column='Orbit_Inclination', max_digits=4, decimal_places=2)  # Field name made lowercase.
    ephemeris_source = models.CharField(db_column='Ephemeris_Source', max_length=45, blank=True, null=True)  # Field name made lowercase.
    eod_administators = models.ForeignKey('EodAdministators', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'EXO_OBJECTS'


class LimbDarkeningCoefficients(models.Model):
    ldc_id = models.CharField(db_column='LDC_ID', max_length=45)  # Field name made lowercase.
    filter = models.CharField(db_column='Filter', max_length=5)  # Field name made lowercase.
    u1 = models.DecimalField(db_column='U1', max_digits=10, decimal_places=9)  # Field name made lowercase.
    u2 = models.DecimalField(db_column='U2', max_digits=10, decimal_places=9)  # Field name made lowercase.
    exo_objects = models.ForeignKey(ExoObjects, models.DO_NOTHING, db_column='EXO_OBJECTS_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'LIMB_DARKENING_COEFFICIENTS'


class LinkExoObjectsAndVsx(models.Model):
    exo_objects = models.ForeignKey(ExoObjects, models.DO_NOTHING, db_column='EXO_OBJECTS_id')  # Field name made lowercase.
    vsx = models.ForeignKey('Vsx', models.DO_NOTHING, db_column='VSX_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'LINK_EXO_OBJECTS_and_VSX'
        unique_together = (('exo_objects', 'vsx'),)


class LinkObservationsAndHqPerson(models.Model):
    observations = models.ForeignKey('Observations', models.DO_NOTHING, db_column='OBSERVATIONS_id')  # Field name made lowercase.
    hq_person = models.ForeignKey('HqPerson', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'LINK_OBSERVATIONS_and_hq_person'
        unique_together = (('observations', 'hq_person'),)


class Observations(models.Model):
    id = models.IntegerField(primary_key=True)
    observation_id = models.CharField(max_length=45, blank=True, null=True)
    begin_time = models.DateTimeField(db_column='Begin_Time')  # Field name made lowercase.
    meridian_flip_flag = models.IntegerField(db_column='Meridian_Flip_Flag')  # Field name made lowercase.
    meridian_flip_time = models.DateTimeField(db_column='Meridian_Flip_Time', blank=True, null=True)  # Field name made lowercase.
    transit_time_standard = models.CharField(db_column='Transit_Time_Standard', max_length=7)  # Field name made lowercase.
    predicted_ingress = models.DecimalField(db_column='Predicted_Ingress', max_digits=16, decimal_places=9)  # Field name made lowercase.
    predicted_egress = models.DecimalField(db_column='Predicted_Egress', max_digits=16, decimal_places=9)  # Field name made lowercase.
    bias_files_zip_filename = models.CharField(db_column='Bias_Files_Zip_Filename', max_length=45, blank=True, null=True)  # Field name made lowercase.
    dark_files_zip_filename = models.CharField(db_column='Dark_Files_Zip_Filename', max_length=45, blank=True, null=True)  # Field name made lowercase.
    flat_files_zip_filename = models.CharField(db_column='Flat_Files_Zip_Filename', max_length=45, blank=True, null=True)  # Field name made lowercase.
    flat_dark_files_zip_filename = models.CharField(db_column='Flat_Dark_Files_Zip_Filename', max_length=45, blank=True, null=True)  # Field name made lowercase.
    results_depth = models.DecimalField(db_column='Results_Depth', max_digits=10, decimal_places=9, blank=True, null=True)  # Field name made lowercase.
    results_a_r_field = models.DecimalField(db_column='Results_a/R*', max_digits=11, decimal_places=9, blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.
    results_tc = models.DecimalField(db_column='Results_Tc', max_digits=16, decimal_places=9, blank=True, null=True)  # Field name made lowercase.
    results_orbital_incl = models.DecimalField(db_column='Results_Orbital_Incl', max_digits=7, decimal_places=6, blank=True, null=True)  # Field name made lowercase.
    results_rms = models.DecimalField(db_column='Results_RMS', max_digits=7, decimal_places=6, blank=True, null=True)  # Field name made lowercase.
    detrend_airmass = models.IntegerField(db_column='Detrend_Airmass', blank=True, null=True)  # Field name made lowercase.
    detrend_meridian_flip = models.IntegerField(db_column='Detrend_Meridian_Flip', blank=True, null=True)  # Field name made lowercase.
    detrend_target_width = models.IntegerField(db_column='Detrend_Target_Width', blank=True, null=True)  # Field name made lowercase.
    target_sky_cnts_pixel = models.IntegerField(db_column='Target_Sky_Cnts/Pixel', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    detrend_target_x_fits_field = models.IntegerField(db_column='Detrend_Target_X(FITS)', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.
    detrend_target_y_fits_field = models.IntegerField(db_column='Detrend_Target_Y(FITS)', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.
    detrend_total_comp_star_cnts = models.IntegerField(db_column='Detrend_Total_Comp_Star_Cnts', blank=True, null=True)  # Field name made lowercase.
    detrend_jd_utc = models.IntegerField(db_column='Detrend_JD_UTC', blank=True, null=True)  # Field name made lowercase.
    detrend_hjd_utc = models.IntegerField(db_column='Detrend_HJD_UTC', blank=True, null=True)  # Field name made lowercase.
    detrend_bjd_utc = models.IntegerField(db_column='Detrend_BJD_UTC', blank=True, null=True)  # Field name made lowercase.
    detrend_bjd_tdb = models.IntegerField(db_column='Detrend_BJD_TDB', blank=True, null=True)  # Field name made lowercase.
    detrend_ccd_temp = models.IntegerField(db_column='Detrend_CCD_Temp', blank=True, null=True)  # Field name made lowercase.
    notes = models.TextField(db_column='Notes', blank=True, null=True)  # Field name made lowercase.
    exo_objects = models.ForeignKey(ExoObjects, models.DO_NOTHING, db_column='EXO_OBJECTS_id')  # Field name made lowercase.
    hq_person = models.ForeignKey('HqPerson', models.DO_NOTHING)
    hq_person_site_site = models.ForeignKey('HqPersonSite', models.DO_NOTHING)
    hq_person_equipment_equipment = models.ForeignKey('HqPersonEquipment', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'OBSERVATIONS'


class ObservationSegments(models.Model):
    id = models.IntegerField(primary_key=True)
    segment_number = models.IntegerField(db_column='Segment_Number')  # Field name made lowercase.
    begin_time = models.DateTimeField(db_column='Begin_Time')  # Field name made lowercase.
    binning = models.CharField(db_column='Binning', max_length=3)  # Field name made lowercase.
    pixel_scale = models.DecimalField(db_column='Pixel_Scale', max_digits=4, decimal_places=2)  # Field name made lowercase.
    exposure_time = models.DecimalField(db_column='Exposure_Time', max_digits=5, decimal_places=1)  # Field name made lowercase.
    filter_used = models.CharField(db_column='Filter_Used', max_length=5)  # Field name made lowercase.
    fwhm = models.DecimalField(db_column='FWHM', max_digits=3, decimal_places=1)  # Field name made lowercase.
    measurements_zip_filename = models.CharField(db_column='Measurements_Zip_Filename', max_length=45, blank=True, null=True)  # Field name made lowercase.
    observations = models.ForeignKey(Observations, models.DO_NOTHING, db_column='OBSERVATIONS_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'OBSERVATION_SEGMENTS'


class TargetCompStar(models.Model):
    id = models.IntegerField(primary_key=True)
    star_number = models.IntegerField(db_column='Star_Number')  # Field name made lowercase.
    target_or_comp = models.IntegerField(db_column='Target_or_Comp')  # Field name made lowercase.
    aperture_radius = models.IntegerField(db_column='Aperture_Radius')  # Field name made lowercase.
    annulus_inner_radius = models.IntegerField(db_column='Annulus_Inner_Radius')  # Field name made lowercase.
    annulus_outer_radius = models.IntegerField(db_column='Annulus_Outer_Radius')  # Field name made lowercase.
    star_ra = models.CharField(db_column='Star_RA', max_length=11, blank=True, null=True)  # Field name made lowercase.
    star_dec = models.CharField(db_column='Star_DEC', max_length=11, blank=True, null=True)  # Field name made lowercase.
    vsd = models.ForeignKey('Vsd', models.DO_NOTHING, db_column='VSD_id')  # Field name made lowercase.
    observation_segments = models.ForeignKey(ObservationSegments, models.DO_NOTHING, db_column='OBSERVATION_SEGMENTS_id')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'TARGET_COMP_STAR'


class Vsd(models.Model):
    id = models.IntegerField(primary_key=True)
    auid = models.CharField(db_column='AUID', max_length=11)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'VSD'


class Vsx(models.Model):
    id = models.IntegerField(primary_key=True)
    auid = models.CharField(db_column='AUID', max_length=11)  # Field name made lowercase.
    rstar = models.DecimalField(db_column='Rstar', max_digits=5, decimal_places=3, blank=True, null=True)  # Field name made lowercase.
    teff = models.IntegerField(db_column='Teff', blank=True, null=True)  # Field name made lowercase.
    fe_h = models.DecimalField(db_column='Fe/H', max_digits=4, decimal_places=2, blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters.
    log_g_field = models.DecimalField(db_column='log(g)', max_digits=4, decimal_places=2, blank=True, null=True)  # Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.

    class Meta:
        managed = True
        db_table = 'VSX'


class EodAdministators(models.Model):
    hq_person = models.ForeignKey('HqPerson', models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'eod_administators'


class ExoplanetExoData(models.Model):
    jd_utc = models.DecimalField(db_column='JD_UTC', max_digits=13, decimal_places=6, blank=True, null=True)  # Field name made lowercase.
    hjd_utc = models.DecimalField(db_column='HJD_UTC', max_digits=13, decimal_places=6, blank=True, null=True)  # Field name made lowercase.
    bjd_tdb = models.DecimalField(db_column='BJD_TDB', max_digits=13, decimal_places=6, blank=True, null=True)  # Field name made lowercase.
    differential_magnitude = models.DecimalField(max_digits=8, decimal_places=6, blank=True, null=True)
    mag_uncertainty = models.DecimalField(max_digits=8, decimal_places=6, blank=True, null=True)
    detrend_1 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    detrend_2 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    detrend_3 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    detrend_4 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    added_date = models.DecimalField(max_digits=13, decimal_places=6, blank=True, null=True)
    exoplanet_exo_observation = models.ForeignKey('ExoplanetExoObservation', models.DO_NOTHING, db_column='exoplanet.exo_observation_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'exoplanet.exo_data'


class ExoplanetExoObservation(models.Model):
    auid = models.CharField(db_column='AUID', max_length=11, blank=True, null=True)  # Field name made lowercase.
    star_name = models.CharField(max_length=45, blank=True, null=True)
    exoplanet_name = models.CharField(max_length=45, blank=True, null=True)
    obscode = models.CharField(max_length=5, blank=True, null=True)
    software = models.CharField(max_length=45, blank=True, null=True)
    obstype = models.IntegerField(blank=True, null=True)
    secondary_stars = models.CharField(max_length=45, blank=True, null=True)
    secondary_obscodes = models.CharField(max_length=50, blank=True, null=True)
    exposure_time = models.DecimalField(max_digits=5, decimal_places=1, blank=True, null=True)
    binning = models.CharField(max_length=3, blank=True, null=True)
    filter = models.CharField(max_length=5, blank=True, null=True)
    reference_star_filename = models.CharField(max_length=45, blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    detrend_name_1 = models.CharField(max_length=45, blank=True, null=True)
    detrend_name_2 = models.CharField(max_length=45, blank=True, null=True)
    detrend_name_3 = models.CharField(max_length=45, blank=True, null=True)
    detrend_name_4 = models.CharField(max_length=45, blank=True, null=True)
    priors = models.CharField(max_length=45, blank=True, null=True)
    results = models.CharField(max_length=45, blank=True, null=True)
    valflag = models.CharField(max_length=1, blank=True, null=True)
    group = models.IntegerField(blank=True, null=True)
    added_date = models.DecimalField(max_digits=13, decimal_places=6, blank=True, null=True)
    web_djanjo_hq_person_site = models.ForeignKey('WebDjanjoHqPersonSite', models.DO_NOTHING, db_column='web_djanjo.hq_person_site_id')  # Field renamed to remove unsuitable characters.
    web_django_hq_person_equipment = models.ForeignKey('WebDjangoHqPersonEquipment', models.DO_NOTHING, db_column='web-django.hq_person_equipment_id')  # Field renamed to remove unsuitable characters.
    exoplanet_names = models.ForeignKey('ExoplanetNames', models.DO_NOTHING, db_column='exoplanet.names_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'exoplanet.exo_observation'


class ExoplanetNames(models.Model):
    id = models.IntegerField(primary_key=True)
    auid = models.CharField(db_column='AUID', max_length=11, blank=True, null=True)  # Field name made lowercase.
    alias_1 = models.CharField(max_length=45, blank=True, null=True)
    alias_2 = models.CharField(max_length=45, blank=True, null=True)
    alias_3 = models.CharField(max_length=45, blank=True, null=True)
    alias_4 = models.CharField(max_length=45, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'exoplanet.names'


class ExoplanetSecondaryObscodeLink(models.Model):
    obscode = models.CharField(max_length=5, blank=True, null=True)
    added_date = models.DecimalField(max_digits=13, decimal_places=6, blank=True, null=True)
    exoplanet_exo_observation = models.ForeignKey(ExoplanetExoObservation, models.DO_NOTHING, db_column='exoplanet.exo_observation_id')  # Field renamed to remove unsuitable characters.
    web_djanjo_hq_person = models.ForeignKey('WebDjanjoHqPerson', models.DO_NOTHING, db_column='web_djanjo.hq_person_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'exoplanet.secondary_obscode_link'


class ExoplanetSecondaryStarLink(models.Model):
    auid = models.CharField(db_column='AUID', max_length=11, blank=True, null=True)  # Field name made lowercase.
    added_date = models.DecimalField(max_digits=13, decimal_places=6, blank=True, null=True)
    exoplanet_exo_observation = models.ForeignKey(ExoplanetExoObservation, models.DO_NOTHING, db_column='exoplanet.exo_observation_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'exoplanet.secondary_star_link'


class HqPerson(models.Model):
    id = models.IntegerField(primary_key=True)
    obscode = models.CharField(max_length=4)

    class Meta:
        managed = True
        db_table = 'hq_person'


class HqPersonEquipment(models.Model):
    equipment_id = models.AutoField(primary_key=True)
    equipment_name = models.CharField(max_length=45)
    telescope = models.CharField(max_length=45)
    spectrograph = models.CharField(max_length=45, blank=True, null=True)
    rpow = models.DecimalField(max_digits=6, decimal_places=1, blank=True, null=True)
    aperture = models.IntegerField()
    fl = models.IntegerField()
    imaging_camera = models.CharField(max_length=45)
    gain = models.DecimalField(max_digits=5, decimal_places=3)
    readout_noise = models.IntegerField()
    dark_current = models.DecimalField(max_digits=4, decimal_places=3)
    linearity = models.IntegerField()
    x_photosites = models.IntegerField()
    y_photosites = models.IntegerField()
    x_photosite_size = models.DecimalField(max_digits=3, decimal_places=1)
    y_photosite_size = models.DecimalField(max_digits=3, decimal_places=1)
    obsolete = models.IntegerField()
    hq_person = models.ForeignKey(HqPerson, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'hq_person_equipment'


class HqPersonSite(models.Model):
    site_id = models.AutoField(primary_key=True)
    sitename = models.CharField(max_length=45)
    sitelat = models.FloatField()
    sitelong = models.FloatField()
    sitealt = models.IntegerField()
    obsolete = models.IntegerField()
    hq_person = models.ForeignKey(HqPerson, models.DO_NOTHING)

    class Meta:
        managed = True
        db_table = 'hq_person_site'


class WebDjangoHqPersonEquipment(models.Model):
    equipment_id = models.AutoField(primary_key=True)
    equipment_name = models.CharField(max_length=45, blank=True, null=True)
    telescope = models.CharField(max_length=45, blank=True, null=True)
    spectrograph = models.CharField(max_length=45, blank=True, null=True)
    rpow = models.DecimalField(max_digits=6, decimal_places=1, blank=True, null=True)
    aperture = models.IntegerField(blank=True, null=True)
    focal_length = models.IntegerField(blank=True, null=True)
    imaging_camera = models.CharField(max_length=45, blank=True, null=True)
    gain = models.DecimalField(max_digits=5, decimal_places=3, blank=True, null=True)
    readout_noise = models.IntegerField(blank=True, null=True)
    dark_current = models.DecimalField(max_digits=4, decimal_places=3, blank=True, null=True)
    linearity = models.IntegerField(blank=True, null=True)
    x_photosites = models.IntegerField(blank=True, null=True)
    y_photosites = models.IntegerField(blank=True, null=True)
    x_photosite_size = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)
    y_photosite_size = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)
    obsolete = models.IntegerField(blank=True, null=True)
    added_date = models.DateTimeField(blank=True, null=True)
    web_djanjo_hq_person = models.ForeignKey('WebDjanjoHqPerson', models.DO_NOTHING, db_column='web_djanjo.hq_person_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'web_django.hq_person_equipment'


class WebDjanjoHqPerson(models.Model):
    id = models.IntegerField(primary_key=True)

    class Meta:
        managed = True
        db_table = 'web_djanjo.hq_person'


class WebDjanjoHqPersonSite(models.Model):
    site_id = models.IntegerField(primary_key=True)
    sitename = models.CharField(max_length=45, blank=True, null=True)
    sitelat = models.FloatField(blank=True, null=True)
    sitelong = models.FloatField(blank=True, null=True)
    sitealt = models.IntegerField(blank=True, null=True)
    obsolete = models.IntegerField(blank=True, null=True)
    added_date = models.DateTimeField(blank=True, null=True)
    web_djanjo_hq_person = models.ForeignKey(WebDjanjoHqPerson, models.DO_NOTHING, db_column='web_djanjo.hq_person_id')  # Field renamed to remove unsuitable characters.

    class Meta:
        managed = True
        db_table = 'web_djanjo.hq_person_site'
