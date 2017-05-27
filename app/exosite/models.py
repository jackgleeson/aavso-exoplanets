
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
