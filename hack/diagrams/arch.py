#!/usr/bin/env python3
# Copyright 2026 ACRYL Inc. and the JONATHAN GPUBASE Fabric contributors
# SPDX-License-Identifier: MPL-2.0
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Generates docs/images/arch.svg. Run from the repository root: python3 hack/diagrams/arch.py
from xml.sax.saxutils import escape as e
W,H=1280,874
ORG={"ACRYL":"#2B59C3","Yonsei":"#7B3FA0","SKKU":"#1E8E5A","Ajou":"#D9822B","MangoBoost":"#B8930A"}
o=[]
def rect(x,y,w,h,fill,stroke="none",rx=10,dash=None,sw=1.5):
    d=f' stroke-dasharray="{dash}"' if dash else ''
    o.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" fill="{fill}" stroke="{stroke}" stroke-width="{sw}"{d}/>')
def text(x,y,s,size=14,fill="#1b2433",weight="normal",anchor="middle"):
    o.append(f'<text x="{x}" y="{y}" font-size="{size}" fill="{fill}" font-weight="{weight}" text-anchor="{anchor}">{e(s)}</text>')
CH,CS=44,50
def comp(x,y,w,name,desc,org,yr):
    rect(x,y,w,CH,"#ffffff","#d5dbe8",rx=7,sw=1)
    o.append(f'<rect x="{x}" y="{y}" width="6" height="{CH}" rx="3" fill="{ORG[org]}"/>')
    text(x+16,y+19,name,13.5,"#14213d","bold","start")
    text(x+16,y+36,desc,11.5,"#5b6474","normal","start")
    text(x+w-10,y+19,yr,11,"#8a93a3","normal","end")
def section(x,y,w,title,path):
    text(x,y,title,15,"#14213d","bold","start"); text(x+w,y,path,12,"#2B59C3","normal","end")
o.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" font-family="Inter, Segoe UI, Helvetica, Arial, sans-serif">')
o.append('<defs><marker id="ar" markerWidth="10" markerHeight="10" refX="5" refY="5" orient="auto"><path d="M0,0 L10,5 L0,10 z" fill="#4a5568"/></marker></defs>')
rect(0,0,W,H,"#ffffff",rx=16)
text(W/2,40,"JONATHAN GPUBASE Fabric — Architecture",24,"#14213d","bold")
text(W/2,64,"Open-core Ethernet / RoCEv2 GPU cluster network fabric · vendor-neutral, built on SONiC and Kubernetes standard interfaces",13,"#5b6474")
rect(40,84,W-80,62,"#f7f8fb","#9aa3b5",dash="7 5")
text(60,108,"JONATHAN GPUBASE  ·  Commercial Extension (separate product, not in this repository)",14,"#4a5568","bold","start")
text(60,130,"Large-scale cluster ops  ·  Advanced policy management  ·  Integrated visualization  ·  Operations automation  ·  Commercial support",12.5,"#5b6474","normal","start")
o.append(f'<line x1="{W/2}" y1="147" x2="{W/2}" y2="168" stroke="#4a5568" stroke-width="2" marker-end="url(#ar)"/>')
text(W/2+12,163,"depends on api/ only (one-way)",11.5,"#4a5568","normal","start")
rect(40,174,W-80,44,"#14213d",rx=10)
text(W/2,202,"api/  —  Open Control API (gRPC)  ·  CRDs (fabric.gpubase.acryl.ai)  ·  Plugin SPI",15,"#ffffff","bold")
CY0,CY1=232,712
rect(40,CY0,W-80,CY1-CY0,"#eef3ff","#2B59C3",sw=2)
text(60,256,"Open-source Core  (this repository · MPL-2.0)",14,"#2B59C3","bold","start")
TY,RY=290,302
# column A
ax,aw=60,360
section(ax,TY,aw,"Network Fabric Control & Ops","fabric-manager/")
for i,(n,d,org,yr) in enumerate([("switch-manager","SONiC switch control · gNMI/gNOI","ACRYL","Y1–Y3"),("node-resource-manager","K8s DRA · DCGM node resources","ACRYL","Y1–Y2"),("topology-engine","SDN topology awareness","ACRYL","Y2"),("virtual-fabric","RoCEv2 fabric virtualization","ACRYL","Y2"),("dashboard","Operations dashboard prototype","ACRYL","Y1")]):
    comp(ax,RY+i*CS,aw,n,d,org,yr)
fy=RY+5*CS+24
section(ax,fy,aw,"Field Test","field-test/")
for i,(n,d,org,yr) in enumerate([("testbed","RoCEv2 GPU cluster scalability testbed","ACRYL","Y1, Y3"),("scenarios · reports","Validation scenarios · field reports","MangoBoost","Y2–Y3")]):
    comp(ax,fy+12+i*CS,aw,n,d,org,yr)
# column B
bx,bw=440,390
section(bx,TY,bw,"RDMA Traffic Optimization","traffic-optimization/")
for i,(n,d,org,yr) in enumerate([("adaptive-routing","SDN adaptive routing engine","ACRYL","Y1–Y2"),("multipath-transport","Proactive congestion · RDMA multipath","ACRYL","Y2–Y3"),("qos-isolation","RDMA resource isolation · QoS","ACRYL","Y1–Y3"),("observability","Network–PCIe observability · bottleneck","Ajou","Y1"),("workload-placement","Topology-aware workload placement","Ajou","Y1"),("path-selection","GDR / host-staged path selection","Ajou","Y2"),("gpu-native-rdma","GPU-native RDMA management","Ajou","Y3"),("dpu-congestion-control","DPU-based congestion control (PCC)","MangoBoost","Y2–Y3")]):
    comp(bx,RY+i*CS,bw,n,d,org,yr)
# column C
cx=850; cw=W-60-cx
section(cx,TY,cw,"AI Data Acceleration","data-acceleration/")
for i,(n,d,yr) in enumerate([("kv-skipping","DPU context-aware KV skipping","Y2"),("prefix-offload","Prefix-reuse datapath offload","Y2"),("vector-search","GPU–DPU vector search engine","Y3"),("semantic-cache","RDMA semantic cache sharing","Y3")]):
    comp(cx,RY+i*CS,cw,n,d,"Yonsei",yr)
sy=RY+4*CS+24
section(cx,sy,cw,"Security","security/")
for i,(n,d,yr) in enumerate([("security-framework","K8s security analysis framework","Y1"),("access-control","Multi-tenant RDMA access control","Y3"),("security-monitoring","Security monitoring · integrity","Y3")]):
    comp(cx,sy+12+i*CS,cw,n,d,"SKKU",yr)
iy=CY1+16
rect(40,iy,W-80,80,"#f7f8fb","#c3cad8")
text(60,iy+24,"Open standards & hardware (vendor-neutral)",14,"#4a5568","bold","start")
boxes=["Ethernet switch · SONiC","gNMI / gNOI","Kubernetes · DRA","GPU node · DCGM","RNIC · SuperNIC · DPU","RoCEv2 · GPUDirect RDMA"]
bw2=(W-80-40-10*5)/6
for i,b in enumerate(boxes):
    x=60+i*(bw2+10); rect(x,iy+36,bw2,32,"#ffffff","#c3cad8",rx=6,sw=1); text(x+bw2/2,iy+57,b,12,"#14213d")
ly=iy+112; lx=60
text(lx,ly,"Owner:",12,"#4a5568","bold","start"); lx+=54
for n,c in ORG.items():
    o.append(f'<rect x="{lx}" y="{ly-11}" width="14" height="14" rx="3" fill="{c}"/>'); text(lx+20,ly,n,12,"#4a5568","normal","start"); lx+=20+len(n)*7.6+24
text(W-60,ly,"Y1 = 2026 · Y2 = 2027 · Y3 = 2028 (planned year)",12,"#8a93a3","normal","end")
o.append('</svg>')
open("docs/images/arch.svg","w").write("\n".join(o))
