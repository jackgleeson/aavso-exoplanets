from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from .forms import UploadFileForm
from .models import *
from astropy.io import ascii
import pprint


def year_archive(request, year):
    report_list = Report.objects.filter(pub_date__year=year)
    context = {'year': year, 'report_list': report_list}
    return render(request, 'report/year_archive.html', context)


def upload_file(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():

            # save image file
            f = request.FILES['image']
            with open('../files/' + f.name, 'wb+') as destination:
                for chunk in f.chunks():
                    destination.write(chunk)

            # load file
            file_data = request.FILES['report'].read().decode()  # this needs to be chunked

            # parse into ascii table
            report_table = ascii.read(file_data, format='no_header', delimiter="\s", comment="#", data_start=0)

            # extract and set report headers
            report_headers = report_table.meta['comments'][-1].split()
            for index, header in enumerate(report_headers):
                report_table["col" + str(1 + index)].name = header

            # extract report properties
            report_properties = {}
            for i in report_table.meta['comments'][:-1]:
                report_properties[i.split("=")[0]] = i.split("=")[1]

            # exo_report = ExoReport(report_properties, report_table)

            return HttpResponse(pprint.pformat(report_table))
            # return HttpResponseRedirect('/upload/success')
        else:
            return HttpResponse(pprint.pformat(form.errors))
    else:
        form = UploadFileForm()
    return render(request, 'upload/upload.html', {'form': form})


def success(request):
    return render(request, 'upload/success.html')
