from app.exosite.models import *


class ReportMapper:
    mapped = False

    def __init__(self):
        self.data = {}  # of ExoplanetExoDatas
        self.observations = {}  # of ExoplanetExoObservations

    def map_ascii_report_to_exo_models(self,ascii_table_exo_report):
        self.data = self._mapToExoplanetExoData(ascii_table_exo_report)
        ReportMapper.mapped = True
        return

    #
    # jd_utc = models.DecimalField(db_column='JD_UTC', max_digits=13, decimal_places=6, blank=True,
    #                              null=True)  # Field name made lowercase.
    # hjd_utc = models.DecimalField(db_column='HJD_UTC', max_digits=13, decimal_places=6, blank=True,
    #                               null=True)  # Field name made lowercase.
    # bjd_tdb = models.DecimalField(db_column='BJD_TDB', max_digits=13, decimal_places=6, blank=True,
    #                               null=True)  # Field name made lowercase.
    # differential_magnitude = models.DecimalField(max_digits=8, decimal_places=6, blank=True, null=True)
    # mag_uncertainty = models.DecimalField(max_digits=8, decimal_places=6, blank=True, null=True)
    # detrend_1 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    # detrend_2 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    # detrend_3 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    # detrend_4 = models.DecimalField(max_digits=15, decimal_places=6, blank=True, null=True)
    # added_date = models.DecimalField(max_digits=13, decimal_places=6, blank=True, null=True)
    # exoplanet_exo_observation = models.ForeignKey('ExoplanetExoObservation', models.DO_NOTHING,
    #                                               db_column='exoplanet.exo_observation_id')  # Field renamed to remove unsuitable characters.

    def _mapToExoplanetExoData(self, ascii_table_exo_report):
        data = ExoplanetExoData

        # data.jd_utc = ascii_table_exo_report.get_properties.
        return True
